package bookerApi.auth;

import com.intuit.karate.junit5.Karate;

public class TokenRunner {

    @Karate.Test
    Karate testGetToken() {
        return Karate.run().relativeTo(getClass());
    }
}
