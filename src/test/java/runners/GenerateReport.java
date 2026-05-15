package runners;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

import java.io.File;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;
import org.apache.commons.io.FileUtils;

public class GenerateReport {

    public static void generateReport() {

        File reportOutputDirectory = new File("target/cucumber-report");

        Collection<File> jsonFiles = FileUtils.listFiles(
                new File("target/karate-reports"),
                new String[]{"json"},
                true
        );

        List<String> jsonPaths = jsonFiles.stream()
                .map(File::getAbsolutePath)
                .collect(Collectors.toList());

        Configuration configuration =
                new Configuration(reportOutputDirectory, "API Karate Test");

        configuration.addClassifications("Framework", "Karate");
        configuration.addClassifications("Environment", "QA");

        ReportBuilder reportBuilder =
                new ReportBuilder(jsonPaths, configuration);

        reportBuilder.generateReports();
    }
}