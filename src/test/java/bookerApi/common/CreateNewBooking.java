package bookerApi.common;

import com.intuit.karate.junit5.Karate;

public class CreateNewBooking {

    @Karate.Test
    Karate testCreateNewBookingBooking() {
        return Karate.run().relativeTo(getClass()).tags("~@ignore");
    }

}
