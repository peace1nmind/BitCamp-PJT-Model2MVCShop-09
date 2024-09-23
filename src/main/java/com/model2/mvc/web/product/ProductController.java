package com.model2.mvc.web.product;

import java.io.File;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

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
		model.addAttribute("title", (menu!=null && menu.equals("search"))? "��ǰ �����ȸ" : "��ǰ����");
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
			Search saleSearch = new Search(salePage, pageSize);
			Map<String, Object> saleMap = purchaseService.getSaleList(saleSearch);
			model.addAttribute("saleMap", saleMap);
			
			Paging salePaging = new Paging((int) saleMap.get("count"), saleSearch.getCurrentPage(), pageSize, pageUnit);
			model.addAttribute("salePaging", salePaging);
		}
		
		model.addAttribute("tranCodeMap", TranCodeMapper.getInstance().getMap());
		
		return "forward:/product/listProduct.jsp";
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
	public String updateProduct(HttpServletRequest request) 
								throws Exception {
		
		System.out.println("/updateProduct POST");
		
		int no = 1;
		
		/* ���� ���ε� ���� �ʿ� */
		if (FileUpload.isMultipartContent(request)) {
			String uploadDir = "F:BitCamp/workspace/07.Model2MVCShop(URI,pattern)/src/main/webapp/images/uploadFiles/";
			
			DiskFileUpload fileUpload = new DiskFileUpload();
			fileUpload.setRepositoryPath(uploadDir);
			
			// �ִ� ���ε� ������ ���� (-1= ���� ����)
			// 1024 * 1024 * 10
			fileUpload.setSizeMax(1024 * 1024 * 10);
			fileUpload.setSizeThreshold(1024 * 100);
			
			System.out.println(request.getContentLength());
			System.out.println(fileUpload.getSizeMax());
			
			if (request.getContentLength() < fileUpload.getSizeMax()) {
				
				Product product = new Product();
				
				// ���ڿ��� Ư�� ������ �������� ��ū(���ڿ� ����)���� �����µ� ����ϴ� Ŭ����(split �� ����)
				StringTokenizer token = null;
				
				List<FileItem> fileItemList = fileUpload.parseRequest(request);
				
				// html���� ���� ������ ����
				int size = fileItemList.size();
				
				System.out.println(size);
				
				for (FileItem fileItem : fileItemList) {
					System.out.println(fileItem);
					// ���� ����/�Ķ���� ���� Ȯ�� (�Ķ���͸� true)
					if (fileItem.isFormField()) {	// �Ķ���Ͷ��
						if (fileItem.getFieldName().equals("manuDate")) {
							
							String manuDate = "";
							
							if (fileItem.getString("euc-kr").contains("-")) {
								token = new StringTokenizer(fileItem.getString("euc-kr"), "-");
								manuDate = token.nextToken() + token.nextToken() + token.nextToken();
							} else {
								manuDate = fileItem.getString("euc-kr");
							}
							
							product.setManuDate(manuDate);
							
						} else if (fileItem.getFieldName().equals("prodName")) {
							product.setProdName(fileItem.getString("euc-kr"));
							
						} else if (fileItem.getFieldName().equals("prodDetail")) {
							product.setProdDetail(fileItem.getString("euc-kr"));
							
						} else if (fileItem.getFieldName().equals("price")) {
							product.setPrice(Integer.parseInt(fileItem.getString("euc-kr")));
							
						} else if (fileItem.getFieldName().equals("prodNo")) {
							product.setProdNo(Integer.parseInt(fileItem.getString("euc-kr")));

						}
						
						
					} else { // ���� �����̸�
						if (fileItem.getSize() > 0) { // ������ ������
							int index = (fileItem.getName().contains("\\"))? 
											fileItem.getName().lastIndexOf("\\") : 
											fileItem.getName().lastIndexOf("/");
							
							String fileName = fileItem.getName().substring(index+1);
							
							product.setFileName(fileName);
							
							try {
								File uploadFile = new File(uploadDir, fileName);
								fileItem.write(uploadFile);
								
								// ���� ���ε� ó�� ��
								Thread.sleep(2000); // 2�� ���� ���
								
							} catch (Exception e) {
								e.printStackTrace();
								
							}
							
						} else { // ������ ������
							product.setFileName("empty.GIF");
							
						}
					}
				} // for end	
				
				product = productService.updateProduct(product);
				
				request.setAttribute("product", product); 
					
			} else {
				// ���ε��ϴ� ������ setSizeMax���� ū ���
				int overSize = (request.getContentLength() / 1000000);
				
				System.out.println("<script>alert('������ ũ��� 1MB���� �˴ϴ�. �ø��� ���� �뷮�� " + overSize + "MB �Դϴ�.');");
				System.out.println("history.back();</script>");
			}
			
		} else {
			System.out.println("���ڵ� Ÿ���� multipart/form-data�� �ƴմϴ�");
		}
		
		
//		product = productService.updateProduct(product);
//		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
	}
	
	
	// ��ǰ���
	@GetMapping("/addProduct")
	public String addProduct() {
		
		System.out.println("/product/addProduct GET");
		
		return "redirect:/product/addProductView.jsp";
	}
	
	@PostMapping("/addProduct")
	public String addProduct(HttpServletRequest request) 
							 throws Exception {
		
		System.out.println("/product/addProduct POST");
		
		/* Spring mvc ���� ���ε� �����ϱ� */
		/* ���� ���ε� ��� ��Ÿ�����ͷ� �����ϱ� */
		if (FileUpload.isMultipartContent(request)) {
			String uploadDir = "F:BitCamp/workspace/07.Model2MVCShop(URI,pattern)/src/main/webapp/images/uploadFiles/";
			
			DiskFileUpload fileUpload = new DiskFileUpload();
			fileUpload.setRepositoryPath(uploadDir);
			
			// �ִ� ���ε� ������ ���� (-1= ���� ����)
			// 1024 * 1024 * 10
			fileUpload.setSizeMax(1024 * 1024 * 10);
			fileUpload.setSizeThreshold(1024 * 100);
			
			System.out.println(request.getContentLength());
			
			if (request.getContentLength() < fileUpload.getSizeMax()) {
				
				Product product = new Product();
				
				// ���ڿ��� Ư�� ������ �������� ��ū(���ڿ� ����)���� �����µ� ����ϴ� Ŭ����(split �� ����)
				StringTokenizer token = null;
				
				List<FileItem> fileItemList = fileUpload.parseRequest(request);
				
				// html���� ���� ������ ����
				int size = fileItemList.size();
				
				for (FileItem fileItem : fileItemList) {
					
					// ���� ����/�Ķ���� ���� Ȯ�� (�Ķ���͸� true)
					if (fileItem.isFormField()) {	// �Ķ���Ͷ��
						if (fileItem.getFieldName().equals("manuDate")) {
							token = new StringTokenizer(fileItem.getString("euc-kr"), "-");
							String manuDate = token.nextToken() + token.nextToken() + token.nextToken();
							
							product.setManuDate(manuDate);
							
						} else if (fileItem.getFieldName().equals("prodName")) {
							product.setProdName(fileItem.getString("euc-kr"));
							
						} else if (fileItem.getFieldName().equals("prodDetail")) {
							product.setProdDetail(fileItem.getString("euc-kr"));
							
						} else if (fileItem.getFieldName().equals("price")) {
							product.setPrice(Integer.parseInt(fileItem.getString("euc-kr")));
							
						}
						
					} else { // ���� �����̸�
						if (fileItem.getSize() > 0) { // ������ ������
							int index = (fileItem.getName().contains("\\"))? 
											fileItem.getName().lastIndexOf("\\") : 
											fileItem.getName().lastIndexOf("/");
							
							String fileName = fileItem.getName().substring(index+1);
							
							product.setFileName(fileName);
							
							try {
								File uploadFile = new File(uploadDir, fileName);
								fileItem.write(uploadFile);
								
								// ���� ���ε� ó�� ��
								Thread.sleep(2000); // 2�� ���� ���
								
							} catch (Exception e) {
								e.printStackTrace();
								
							}
							
						} else { // ������ ������
							product.setFileName("empty.GIF");
							
						}
					}
				} // for end	

				product = productService.addProduct(product);
				
				request.setAttribute("product", product); 
					
			} else {
				// ���ε��ϴ� ������ setSizeMax���� ū ���
				int overSize = (request.getContentLength() / 1000000);
				
				System.out.println("<script>alert('������ ũ��� 1MB���� �˴ϴ�. �ø��� ���� �뷮�� " + overSize + "MB �Դϴ�.');");
				System.out.println("history.back();</script>");
			}
			
		} else {
			System.out.println("���ڵ� Ÿ���� multipart/form-data�� �ƴմϴ�");
		}
		
		return "forward:/product/addProduct.jsp";
		
	}// method end

}
// class end