package org.example;

import org.junit.Test;

import static junit.framework.TestCase.assertEquals;
import static junit.framework.TestCase.assertTrue;

public class CalculatorTest {

    @Test
    public void testAllPositive() {
        double[] results = Calculator.calculateQuadratic(1, 5, 6);

        assertEquals(-2.0, results[0]);
        assertEquals(-3.0, results[1]);
    }

    @Test
    public void testNegativeA() {
        double[] results = Calculator.calculateQuadratic(-2, 3, 5);

        assertEquals(-1.0, results[0]);
        assertEquals(2.5, results[1]);
    }

    @Test
    public void testNegativeB() {
        double[] results = Calculator.calculateQuadratic(2, -5, 3);

        assertEquals(1.5, results[0]);
        assertEquals(1.0, results[1]);
    }

    @Test
    public void testNegativeC() {
        double[] results = Calculator.calculateQuadratic(2, 3, -10);

        assertEquals(1.6084952830141508, results[0]);
        assertEquals(-3.108495283014151, results[1]);
    }

    @Test
    public void testImaginaryNumbers() {
        double[] results = Calculator.calculateQuadratic(1, 2, 3);

        assertTrue(Double.isNaN(results[0]) && Double.isNaN(results[1]));
    }
}
