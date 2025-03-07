public class StoreFrontController {
	//Se cra una lista de la mercancia a ver
	List<DisplayMerchandise> shoppingCart = new List<DisplayMerchandise>();
// Action method to handle purchasing process
	public PageReference addToCart() {
		for(DisplayMerchandise p : products) {
			if(0 < p.qtyToBuy) {
			shoppingCart.add(p);
			}
		}

		return null; // stay on the same page
	}
			
	public String getCartContents() {
		Decimal total = 0.00;
			if(0 == shoppingCart.size()) {
			return '(empty)';
			}	
			String msg = '<ul>\n';
			for(DisplayMerchandise p : shoppingCart) {
				msg += '<li>';
					msg += p.name + ' (' + p.qtyToBuy + ') Precio:' + p.price ;
				msg += '</li>\n';
			total += (p.qtyToBuy * p.price);
			}
			msg += total;
			msg += '</ul>';
		return msg;
	}

	List<DisplayMerchandise> products;
	
	public List<DisplayMerchandise> getProducts() {
		if(products == null) {
			products = new List<DisplayMerchandise>();
			for(Merchandise__c item : [
			SELECT Id, Name, Description__c, Price__c, Total_Inventory__c
			FROM Merchandise__c]) {
			products.add(new DisplayMerchandise(item));
			}
		}
	return products;
	}
	// Inner class to hold online store details for item
	public class DisplayMerchandise {

		private Merchandise__c merchandise;

		public DisplayMerchandise(Merchandise__c item) {
			this.merchandise = item;
		}
		// Properties for use in the Visualforce view
		public String name {
		get { return merchandise.Name; }
		}
		public String description {
		get { return merchandise.Description__c; }
		}
		public Decimal price {
		get { return merchandise.Price__c; }
		}
		public Boolean inStock {
		get { return (0 < merchandise.Total_Inventory__c); }
		}
		public Integer qtyToBuy { get; set; }
	}


}