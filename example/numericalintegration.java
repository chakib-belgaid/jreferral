class NumericalIntegration
{
 
  interface FPFunction
  {
    double eval(double n);
  }
 
  public static double rectangularLeft(double a, double b, int n, FPFunction f)
  {
    return rectangular(a, b, n, f, 0);
  }
 
  public static double rectangularMidpoint(double a, double b, int n, FPFunction f)
  {
    return rectangular(a, b, n, f, 1);
  }
 
  public static double rectangularRight(double a, double b, int n, FPFunction f)
  {
    return rectangular(a, b, n, f, 2);
  }
 
  public static double trapezium(double a, double b, int n, FPFunction f)
  {
    double range = checkParamsGetRange(a, b, n);
    double nFloat = (double)n;
    double sum = 0.0;
    for (int i = 1; i < n; i++)
    {
      double x = a + range * (double)i / nFloat;
      sum += f.eval(x);
    }
    sum += (f.eval(a) + f.eval(b)) / 2.0;
    return sum * range / nFloat;
  }
 
  public static double simpsons(double a, double b, int n, FPFunction f)
  {
    double range = checkParamsGetRange(a, b, n);
    double nFloat = (double)n;
    double sum1 = f.eval(a + range / (nFloat * 2.0));
    double sum2 = 0.0;
    for (int i = 1; i < n; i++)
    {
      double x1 = a + range * ((double)i + 0.5) / nFloat;
      sum1 += f.eval(x1);
      double x2 = a + range * (double)i / nFloat;
      sum2 += f.eval(x2);
    }
    return (f.eval(a) + f.eval(b) + sum1 * 4.0 + sum2 * 2.0) * range / (nFloat * 6.0);
  }
 
  private static double rectangular(double a, double b, int n, FPFunction f, int mode)
  {
    double range = checkParamsGetRange(a, b, n);
    double modeOffset = (double)mode / 2.0;
    double nFloat = (double)n;
    double sum = 0.0;
    for (int i = 0; i < n; i++)
    {
      double x = a + range * ((double)i + modeOffset) / nFloat;
      sum += f.eval(x);
    }
    return sum * range / nFloat;
  }
 
  private static double checkParamsGetRange(double a, double b, int n)
  {
    if (n <= 0)
      throw new IllegalArgumentException("Invalid value of n");
    double range = b - a;
    if (range <= 0)
      throw new IllegalArgumentException("Invalid range");
    return range;
  }
 
 
  private static void testFunction(String fname, double a, double b, int n, FPFunction f)
  {
     rectangularLeft(a, b, n, f);
     rectangularMidpoint(a, b, n, f);
     rectangularRight(a, b, n, f);
     trapezium(a, b, n, f);
     simpsons(a, b, n, f);
    return;
  }
 
  public static void main(String[] args)
  { for (int i =0 ; i < 3;i++){
    testFunction("x^3+5/(x^2+3)", 1.0, 5.0, 100000000, new FPFunction() {
        public double eval(double n) {
          return (n * n * n+5)/(n*n+3);
        }
      }
    );
 
    };
 
    return;
  }
}