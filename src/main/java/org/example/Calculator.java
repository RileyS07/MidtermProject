package org.example;

import java.util.List;

public class Calculator {

    /*
        Code development (IntelliJ IDEA)
        Version control (GitHub)
        Build automation (Maven)
        Unit testing (JUnit)
        Release automation / CI / CD (Jenkins)
        Application deployment (Docker)
     */

    static void main(String[] args) {
        System.out.println("Application has started now and has successfully ran the unit tests!");
    }

    // Calculates the quadratic formula given a b and c.
    public static double[] calculateQuadratic(double a, double b, double c) {
        // x = -b +- sqrt(b^2 - 4ac) / 2a
        double bSquared = b * b;
        double rootFactor = Math.sqrt(bSquared - (4 * a * c ));
        double firstValue = (-b + rootFactor) / (2 * a);
        double secondValue = (-b - rootFactor) / (2 * a);

        return new double[] {firstValue, secondValue};
    }
}
