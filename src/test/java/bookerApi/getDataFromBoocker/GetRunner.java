package bookerApi.getDataFromBoocker;

import com.intuit.karate.junit5.Karate;

public class GetRunner {

    @Karate.Test
    Karate testGetBooking() {
        return Karate.run().relativeTo(getClass()).tags("~@ignore");
    }

}
