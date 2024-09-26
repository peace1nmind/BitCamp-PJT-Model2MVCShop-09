package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Paging;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.TranCodeMapper;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

// W 24.09.12.start 

@Controller
@RequestMapping("/product/*")
public class ProductController {

	// Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@Value("#{fileProperties['uploadDir']}")
	String uploadDir;

	// Constructor
	public ProductController() {
		System.out.println(":: " +  getClass().getSimpleName() + " default Constructor call\n");
	}

	// Method
	// ��ǰ���
	@RequestMapping("/listProduct")
	public String listProduct(@RequestParam("menu") String menu,
							  @ModelAttribute("search") Search search,
							  @RequestParam(name = "salePage", required = false, defaultValue = "1") int salePage,
							  Model model) throws Exception {
		
		System.out.println("/listProduct");
		
		// ��ǰ ��� / ��ǰ ���� ���� ����
		// menu: search , manage
		model.addAttribute("menu" ,menu);
		model.addAttribute("title", (menu!=null && menu.equals("search"))? "��ǰ �����ȸ" : "��ǰ���� (�Ǹ���)");
		model.addAttribute("navi", (menu!=null && menu.equals("search"))? "getProduct" : "updateProduct");
		
		
		// �˻� ������ �ٷ�� ����
		search.setPageSize(pageSize);
		model.addAttribute(search);
		
		
		// �˻��� ����Ʈ������ �ٷ�� ���� (list, count)
		/* �Ǹ����� ��ǰ�� (listProduct) */
		Map<String, Object> map = productService.getProductList(search);
		model.addAttribute("map" ,map);
		
		// �������� �ٷ�� ����
		Paging paging = new Paging((int) map.get("count"), search.getCurrentPage(), pageSize, pageUnit);
		model.addAttribute("paging" ,paging);
		
		
		/* ���ſϷ� ��ǰ�� (listSale) */
		if (menu.equals("manage")) {
			Search saleSearch = search;
			saleSearch.setCurrentPage(salePage);
			saleSearch.setPageSize(pageSize);
			
			System.out.println(String.format("\n\nsearch= %s \n\n", search));
			System.out.println(String.format("\n\nsaleSearch=  %s \n\n", saleSearch));
			
			Map<String, Object> saleMap = purchaseService.getSaleList(saleSearch);
			model.addAttribute("saleMap", saleMap);
			
			Paging salePaging = new Paging((int) saleMap.get("count"), saleSearch.getCurrentPage(), pageSize, pageUnit);
			model.addAttribute("salePaging", salePaging);
		}
		
		model.addAttribute("tranCodeMap", TranCodeMapper.getInstance().getMap());
		
		return "/product/listProduct.jsp";
	}
	
	
	// ��ǰ����
	@RequestMapping("/getProduct")
	public String getProduct(@RequestParam("prodNo") String prodNo,
							 HttpServletRequest request,
							 HttpServletResponse response,
							 Model model) throws NumberFormatException, Exception {
		
		System.out.println("/getProduct");
		
		// ��ǰ������ �������� ����
		model.addAttribute("product", productService.getProduct(Integer.parseInt(prodNo)));
		
		
		// �ֱ� �� ��ǰ ����Ʈ ����
		Cookie[] cookies = request.getCookies();
		Cookie history = new Cookie("history", null);
		
		if (cookies != null && cookies.length > 0) {
			for (Cookie cookie : cookies) {
				history = (cookie.getName().equals("history")) ? cookie : history;
			}
		}
		

		String historyValue = history.getValue();
		String value = "";
		
		if (historyValue == null) {
			value = prodNo;
			
		} else {
			
			if (!historyValue.contains(prodNo)) {
				value = prodNo + "&" + historyValue;
				
			} else {
				value = historyValue.replace(prodNo, "");
				
				String[] splittedValue = value.split("&");
				value = "";
				
				for (int i = 0; i < splittedValue.length; i++) {
					
					if (!(splittedValue[i]==null || splittedValue[i].equals(""))) {
						value += splittedValue[i] + ((i < splittedValue.length -1)? "&" : "");
						
					}
				}
				
				value = prodNo + "&" + value;
				
			}
	
		}
		
		history.setValue(value);
		response.addCookie(history);
		
		return "forward:/product/getProduct.jsp";
	}
	
	
	// ��ǰ���� ����
	@GetMapping("/updateProduct")
	public String updateProduct(@RequestParam("prodNo") int prodNo,
								Model model) throws Exception {
		
		System.out.println("/updateProduct GET");
		
		model.addAttribute("product", productService.getProduct(prodNo));
		
		return "forward:/product/updateProductView.jsp";
	}
	
	@PostMapping("/updateProduct")
	public String updateProduct(@ModelAttribute("product") Product product) 
								throws Exception {
		
		System.out.println("/updateProduct POST");
		
		String uuid = UUID.randomUUID().toString().split("-")[0];
		String fileExtension = product.getFileName().substring(product.getFileName().lastIndexOf("."));
		String uploadFileName = uuid + fileExtension;
		
		product.getFile().transferTo(new File(uploadDir + uploadFileName));
		
		product.setFileName(uploadFileName);
		Thread.sleep(2000);
		
		product = productService.updateProduct(product);
		
		return "forward:/product/updateProduct.jsp";
	}
	
	
	// ��ǰ���
	@GetMapping("/addProduct")
	public String addProduct() {
		
		System.out.println("/product/addProduct GET");
		
		return "redirect:/product/addProductView.jsp";
	}
	
	/* Spring MVC�� Ȱ���� ���� ���ε� */
	@PostMapping("/addProduct")
	public String addProduct(@ModelAttribute("product") Product product) {
		
		System.out.println("/product/addProduct POST");

		// �����̸��� ��ĥ���� �ְ� ������ ������ ������ ���� �̸��� ���
		String uuid = UUID.randomUUID().toString().split("-")[0];
		String fileExtension = product.getFileName().substring(product.getFileName().lastIndexOf("."));
		String uploadFileName = uuid + fileExtension;
		
		System.out.println("���ε��� ���丮 : "+uploadDir);
		System.out.println("\n");
		File uploadFile = new File(uploadDir+uploadFileName);
		
		try {
			product.getFile().transferTo(uploadFile);
			Thread.sleep(2000);
			
		} catch (IllegalStateException e) {
			e.printStackTrace();
			
		} catch (IOException e) {
			e.printStackTrace();
			
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		product.setFileName(uploadFileName);
		
		product = productService.addProduct(product);
		
		return "forward:/product/addProduct.jsp";
	}

}
// class end