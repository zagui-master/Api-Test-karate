package bookerApi.helpers;

import com.intuit.karate.junit5.Karate;

public class GenerateTestDataRunner {

    @Karate.Test
    Karate testGetBooking() {
        return Karate.run().relativeTo(getClass()).tags("~@ignore");
    }

}
