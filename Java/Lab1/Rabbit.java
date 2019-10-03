import java.util.Random;

public class Rabbit extends Animal implements Runnable {
  int sleeping_time;

  public Rabbit() {
    super();
    this.sleeping_time = 100;
  }

  public Rabbit(int race_length, int sleeping_time) {
    super(race_length);
    this.sleeping_time = sleeping_time;
  }

  public void run() {
    Random random = new Random();
    while(current_length < race_length && !Thread.currentThread().isInterrupted()) {
      int ran = random.nextInt((1000 - 500) + 1) + 500;
      current_length += ran;
      System.out.println("The rabbit ran " + ran + " mts. Total = " + current_length);
      if(current_length >= race_length) break;
      try {
        System.out.println("The rabbit is sleeping...");
        Thread.sleep(sleeping_time);
        System.out.println("The rabbit woke up");
      } catch(InterruptedException ex) {
        System.out.println("The rabbit did not finished the race");
        Thread.currentThread().interrupt();
      }
    }
    finish = true;
  }
}
