package org.example;

import java.util.List;

public class Calculator {

    static void main(String[] args) {
        double[] results = calculateQuadratic(1, 2, 3);
        System.out.println(results[0] + ", "  + results[1]);


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
