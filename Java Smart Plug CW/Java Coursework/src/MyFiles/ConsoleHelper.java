package MyFiles;

import java.util.Scanner;

//RESPONSIBLE FOR
//outputting to console
//receiving input from console
public class ConsoleHelper {
    private Scanner scanner; //open and close inside console helper or separately?

    public ConsoleHelper(Scanner scanner) {
        this.scanner = scanner;
    }

    //output methods
    public void print(String input){
        System.out.println(input);
    }
    public void print(int input){
        System.out.println(input);
    }
    public void print(float input){
        System.out.println(input);
    }

    //input methods
    public String inputString(String input){
        print(input);
        return scanner.nextLine();
    }

    public int inputInt(String input){
        print(input);
        int out = scanner.nextInt();
        scanner.nextLine();
        return out;
    }
}
