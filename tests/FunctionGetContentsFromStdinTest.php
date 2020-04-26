<?php
declare(strict_types=1);

namespace KEINOS\Tests;

final class FunctionGetContentsFromStdinTest extends \PHPUnit\Framework\TestCase
{
    public function testRegularInput()
    {
        $result_expect = 'World!';

        // Register stream wrapper
        $existed = in_array('php', \stream_get_wrappers());
        if ($existed) {
            \stream_wrapper_unregister("php");
        }
        \stream_wrapper_register("php", '\\KEINOS\Tests\MockPhpStream');

        // Set value to STDIN
        \file_put_contents('php://stdin', $result_expect);

        // Get value from function and restore registration
        $result_actual = \KEINOS\Sample\getContentsFromStdin();
        \stream_wrapper_restore("php");

        // Test
        $this->assertSame($result_expect, $result_actual);
    }
}
