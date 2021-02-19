package com.blueharvest.bluedev.bedrocksb;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class BedrockSbApplicationTests {

    @Test
    @DisplayName("SHOULD run without exceptions WHEN application is started")
    void main() {
        BedrockSbApplication.main(new String[]{});
    }

}