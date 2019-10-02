public class HelloThread extends Thread {
  @Override
  public void run() {
    System.out.println("Hello from a thread!");
  }

  private static void main(String args[]) {
    (new HelloThread()).start();
  }
}
