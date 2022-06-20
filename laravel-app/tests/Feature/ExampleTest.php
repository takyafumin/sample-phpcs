<?php
declare(strict_types=1);

namespace Tests\Feature;

use Tests\TestCase;

/**
 * Example Test
 */
class ExampleTest extends TestCase
{
    /**
     * A basic test example.
     *
     * @return void
     */
    public function test_the_application_returns_a_successful_response()
    {
        $response = $this->get('/');

        $response->assertStatus(200);
    }
}
