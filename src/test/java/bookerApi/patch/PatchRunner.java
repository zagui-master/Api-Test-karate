package bookerApi.patch;

import com.intuit.karate.junit5.Karate;

public class PatchRunner {

    @Karate.Test
    Karate testPatchBooking() {
        return Karate.run().relativeTo(getClass()).tags("~@ignore");
    }
}
