package runners;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.AfterAll;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class RunnersTest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:features")
                .tags("@login_success")
                .outputCucumberJson(true)
                .parallel(1);

        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
    @AfterAll
    public static void generateReport() {
        GenerateReport.generateReport();
    }

}s
