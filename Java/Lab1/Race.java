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
    while(rabbit.get_finished() == false && turtle.get_finished() == false) {
      r.join(100);
      t.join(100);
      if(rabbit.get_finished()) {
        System.out.println("The rabbit won the race!");
        t.interrupt();
        t.join();
        break;
      }
      if(turtle.get_finished()) {
        System.out.println("The turtle won the race!");
        r.interrupt();
        r.join();
        break;
      }
    }
    System.out.println("The race has finished");
  }

  public static void main(String args[]) throws InterruptedException{
    System.out.println("Go:");
    Race race2 = new Race(1_000, 0, 1);
    race2.run();


  }
}
