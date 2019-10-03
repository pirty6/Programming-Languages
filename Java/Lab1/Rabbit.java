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
    while(current_length < race_length) {
      //System.out.println(current_length);
      current_length += random.nextInt((1000 - 500) + 1) + 500;
      try {
        Thread.sleep(sleeping_time);
      } catch(InterruptedException ex) {
        Thread.currentThread().interrupt();
      }
    }
    finish = true;
    System.out.println("The rabbit won the race!");
  }
}
