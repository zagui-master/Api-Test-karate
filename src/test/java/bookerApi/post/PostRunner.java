package bookerApi.post;

import com.intuit.karate.junit5.Karate;

public class PostRunner {

    @Karate.Test
    Karate testPostBooking() {
        return Karate.run().relativeTo(getClass()).tags("~@ignore");
    }
}
