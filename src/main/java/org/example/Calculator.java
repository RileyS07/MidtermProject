package org.example;

public class Calculator {

    /*
        Code development (IntelliJ IDEA)
        Version control (GitHub)
        Build automation (Maven)
        Unit testing (JUnit)
        Release automation / CI / CD (Jenkins)
        Application deployment (Docker)
     */

    /*
        Robust CI/CD Pipeline with Staging and Production Environments

        Create separate staging and production pipelines in Jenkins, explaining the purpose of each.
        Integrate automated testing and logging at each stage to ensure stability before promoting to production.
        Configure rollback mechanisms and demonstrate a rollback scenario for handling a failed deployment.
     */

    /*
        Similar to the midterm, the deliverable for this final project is a recorded
        live demonstration (minimum requirements: video screen share with audio voice over) of your
        integrated DevOps pipeline which utilizes the concepts and tools noted here.

        As part of your demonstration, you should also discuss the concepts / tools you are using,
        their relevance / utility to software developers, and so on.

        There is no time / length requirement, but I have trouble imagining a demonstration that is
        less than ten or fifteen minutes in duration meeting expectations here.

        Remember: we are not looking to demonstrate these tools in isolation but rather to demonstrate how
        they work together!
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

    public static void anotherMethod() {
        System.out.println("Yes.");
    }
}
