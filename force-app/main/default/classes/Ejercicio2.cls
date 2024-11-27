public class Ejercicio2 {
    
    List<Alumno> LAlumnos = new List<Alumno>();
    
    public void numerosPares(){
        for(Integer a = 0; a <= 20;a++){
            if(math.mod(a, 2) == 0){
                System.debug(a);
            }
        }
    }
    
    public void numerosImpares(){
        Integer sum = 0;
        for(integer a = 0; a <= 20;a++){
            if(math.mod(a,2) != 0){
                sum = sum +a;
                System.debug(a);
                System.debug(sum);
            }
        }
    }
    
    public void esAprobado(List<Alumno> alumnos){
        for(Alumno a: alumnos){
            if(a.Calificacion > 5){
                System.debug(a.Nombre + ' Aprobado');
            }else{
                System.debug(a.Nombre + ' Reprobado');
            }
        }
    }

}