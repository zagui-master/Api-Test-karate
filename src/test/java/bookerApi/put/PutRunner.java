package bookerApi.put;

import com.intuit.karate.junit5.Karate;

public class PutRunner {

    @Karate.Test
    Karate testUpdateBooking() {
        return Karate.run().relativeTo(getClass()).tags("~@ignore");
    }
}
