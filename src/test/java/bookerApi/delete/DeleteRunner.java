package bookerApi.delete;

import com.intuit.karate.junit5.Karate;

public class DeleteRunner {

    @Karate.Test
    Karate testDeleteBooking() {
        return Karate.run().relativeTo(getClass());
    }
}
