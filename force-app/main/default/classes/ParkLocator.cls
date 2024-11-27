public class ParkLocator {

	public static String[] country(String myCountry){
		ParkService.ParksImplPort  np = new ParkService.ParksImplPort();
		return np.byCountry(myCountry);
	}

}