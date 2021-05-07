
package com.shivi;
import java .util.Scanner;
public class MainJava {

    public static void main (String[]args){
    Scanner sc = new Scanner (System.in);
  System.out.println("Enter the balance");
 double balance =sc.nextDouble();
   System.out.println("enter the withdrawal amount");
   double amount = sc.nextDouble();
   double remening_balance;
                 if(amount%5==0){
                        if(amount<=balance){
                            remening_balance =balance-amount-0.5;
                          System.out.println(remening_balance);
                        }   
                        else{
           System.out.println("balance");
                        }
     

           }
}
}