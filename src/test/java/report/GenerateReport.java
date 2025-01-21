package report;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import net.masterthought.cucumber.Reportable;
import net.masterthought.cucumber.json.support.Status;
import net.masterthought.cucumber.presentation.PresentationMode;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class GenerateReport {
    public static void main(String[] args) {

        File reportOutputDirectory = new File("target");
        List<String> jsonFiles = new ArrayList<>();
        File reportFolder = new File("target/karate-reports");

        if (reportFolder.exists() && reportFolder.isDirectory()) {
            File[] jsonFilesArray = reportFolder.listFiles((dir, name) -> name.endsWith(".json"));

            if (jsonFilesArray != null) {
                for (File file : jsonFilesArray) {
                    jsonFiles.add(file.getAbsolutePath());
                }
            }
        }

        String buildNumber = "1";
        String projectName = "cucumberProject";

        Configuration configuration = new Configuration(reportOutputDirectory, projectName);
        configuration.setNotFailingStatuses(Collections.singleton(Status.SKIPPED));
        configuration.setBuildNumber(buildNumber);

        configuration.addClassifications("Platform", "Windows");
        configuration.addClassifications("Browser", "Firefox");
        configuration.addClassifications("Branch", "release/1.0");

        configuration.addPresentationModes(PresentationMode.PARALLEL_TESTING);
        configuration.setQualifier("cucumber-report-1", "First report");
        configuration.setQualifier("cucumber-report-2", "Second report");

        ReportBuilder reportBuilder = new ReportBuilder(jsonFiles, configuration);
        Reportable result = reportBuilder.generateReports();

    }
}
