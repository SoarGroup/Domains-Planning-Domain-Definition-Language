public class Pair {
  public Pair(Object f, Object s)
  { 
    car = f;
    cdr = s;   
  }
 
  public Object getCar()
  {
    return car;
  }
 
  public Object getCdr() 
  {
    return cdr;
  }
 
  public String toString()
  { 
    return "(" + car.toString() + ", " + cdr.toString() + ")"; 
  }
 
  private Object car;
  private Object cdr;
}
