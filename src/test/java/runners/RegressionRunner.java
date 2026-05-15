package runners;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class RegressionRunner {

    @Test
    void runRegression() {

        Results results = Runner.path("classpath:features")
                .tags("@regression")
                .outputCucumberJson(true)
                .parallel(1);

        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
    @AfterAll
    public static void generateReport() {
        GenerateReport.generateReport();
    }
}