package com.softka.runner;

import com.intuit.karate.junit5.Karate;

class ApiTestRunner {

    @Karate.Test
    Karate runAllApiTests() {
        return Karate.run("classpath:features/account", "classpath:features/products");
    }
}
