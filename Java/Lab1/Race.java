public class Race {
  Rabbit rabbit;
  Turtle turtle;

  public Race() {
    this.rabbit = new Rabbit();
    this.turtle = new Turtle();
  }

  public Race(int race_length, int sleeping_time, int turtle_speed) {
    this.rabbit = new Rabbit(race_length, sleeping_time);
    this.turtle = new Turtle(race_length, turtle_speed);
  }

  public void run() throws InterruptedException{
    Thread r = new Thread(rabbit);
    Thread t = new Thread(turtle);
    t.start();
    r.start();
    while(r.isAlive() && t.isAlive()) {
      System.out.println(rabbit.get_finished());
        r.join(100);
        t.join(100);
        if(rabbit.get_finished()) {
          t.interrupt();
          t.join();
          break;
        }
        if(turtle.get_finished()) {
          r.interrupt();
          r.join();
          break;
        }
    }
    System.out.println("The race has finished");
  }

  public static void main(String args[]) {
    /*System.out.println("First race:");
    Race race1 = new Race();
    try {
      race1.run();
    } catch(InterruptedException e){
      e.printStackTrace();
    }*/

    System.out.println("Second race");
    Race race2 = new Race(1_000_000_000, 0, 5);
    try {
      race2.run();
    } catch(InterruptedException e) {
      e.printStackTrace();
    }

  }
}
