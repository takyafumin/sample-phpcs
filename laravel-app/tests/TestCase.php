<?php
declare(strict_types=1);

namespace Tests;

use Illuminate\Foundation\Testing\TestCase as BaseTestCase;

/**
 * Test Case
 */
abstract class TestCase extends BaseTestCase
{
    use CreatesApplicationTrait;
}
