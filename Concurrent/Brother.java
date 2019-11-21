public class Brother implements Runnable {
  int id;
  Thread bro;

  public Brother(int id) {
    this.id = id;
    bro = null;
  }

  public void set_brother(Thread bro) {
    this.bro = bro;
  }

  public void run() {
    System.out.println("Im thread no. " + Thread.currentThread().getId() + " and my brother is " + bro.getId());
  }


  public static void main(String args[]) {
      Brother b1 = new Brother(100);
      Brother b2 = new Brother(200);

      Thread t1 = new Thread(b1);
      Thread t2 = new Thread(b2);

      b1.set_brother(t2);
      b2.set_brother(t1);

      t1.start();
      t2.start();

      try {
        t1.join();
        t2.join();
      } catch(InterruptedException ex) {
        ex.printStackTrace();
      }
    }
}
