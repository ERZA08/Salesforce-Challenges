public class Persona {

	Private String nombre { get;set;} {nombre = 'H';}
	Private Integer edad { get;set;} {edad = 0;}
	Private Integer dNI { get;set;} 
	Private String sexo { get;set;} {sexo = 'H';}
	Private Decimal peso { get;set;} {peso = 0.00;}
	Private Decimal altura { get;set;} {altura = 0.00;}

	public Persona(){
		this.dNI = generaDNI();
	}

	public Persona(string pNombre, Integer pEdad, String pSexo){
		this.nombre = pNombre;
		this.edad = pEdad;
		this.sexo = pSexo;
		this.dNI = generaDNI();
	}

	public Persona(string pNombre, Integer pEdad, String pSexo, Integer pDNI, Decimal pPeso, Decimal pAltura){
		this.nombre = pNombre;
		this.edad = pEdad;
		this.sexo = pSexo;
		this.dNI = pDNI;
		this.peso = pPeso;
		this.altura = pAltura;
		this.dNI = generaDNI();
	}

	public Integer calcularIMC(){

		Decimal esUstedGordo =(this.peso/(this.altura * this.altura));
		if( esUstedGordo > 25){
			return 1;
		}else if (esUstedGordo >= 20 && esUstedGordo <= 25){
			return 0;
		}else{
			return -1;
		}
	}
	public String miMensaje(Integer h){
		if(h > 0){
			return 'Baja le a los tacos';
			}else if(h == 0){
				return 'Normal';
				}else {
					return 'Que te pasa come algo';
				}
	}

	public Boolean esMayorDeEdad(){

		return edad >= 18? true:false; 
	}

	public String comprobarSexo(){
		if(this.sexo == 'M'){
			return 'M';
		}else {
			return 'H';
		}
	}

	public Override String toString(){
		return 'Nombre: ' + this.nombre +
				' Edad: ' + this.edad +
				' DNI: ' + this.dNI +
				' Sexo: ' + this.sexo +
				' Peso: ' + this.peso + 
				' Altura: ' + this.altura;
 	}

 	private Integer generaDNI(){
 			final String chars = '0123456789';
		    String randStr = '';
		    while (randStr.length() < 8) {
		       Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
		       randStr += chars.substring(idx, idx+1);
		    }
		    return Integer.valueOf(randStr) ; 
 	}

}