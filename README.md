[![Build Status](https://travis-ci.org/KEINOS/Practice_PHPUnit-test-of-STDIN.svg?branch=master)](https://travis-ci.org/KEINOS/Practice_PHPUnit-test-of-STDIN)

# PHPUnit Test Sample For STDIN

This is a sample PHPUnit test to check the functionability of the below function, which receives a value from "STDIN" (Standard Input) and returns that value.

```php
function getContentsFromStdin()
{
    $contents = \file_get_contents('php://stdin');
    if($contents === false){
        throw new \RuntimeException('Failed to read contents from STDIN.');
    }

    return $contents;
}
```

## The test

To test the functionability of `STDIN` using PHPUnit, one way is to create a mock that overrides a `php://` stream as a wrapper and replaces the value from `STDIN`.

```php
final class FunctionGetContentsFromStdinTest extends \PHPUnit\Framework\TestCase
{
    public function testRegularInput()
    {
        $result_expect = 'World!';

        // Register stream wrapper "MockPhpStream" to "php://" protocol
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
```

## The Wrapper

The wrapper script to mock the `PHP://` stream.

- [./tests/MockPhpStream.php](./tests/MockPhpStream.php)

This helpful wrapper was made by [Denis](https://www.blogger.com/profile/06252737045102742909) in [his blog post](http://news-from-the-basement.blogspot.com/2011/07/mocking-phpinput.html).

## How to Test

To see the tests in action clone this repo and run the test.

### Test it locally

```shellsession
$ composer install
...
$ composer test
> ./vendor/bin/phpunit --testdox --bootstrap ./vendor/autoload.php tests
PHPUnit 7.5.20 by Sebastian Bergmann and contributors.

GetContentsFromFunction
 ✔ Regular input

Time: 76 ms, Memory: 4.00 MB

OK (1 test, 1 assertion)

```

### Test it via Docker

```shellsession
$ docker build -t test:local .
...
$ docker run --rm test:local
> ./vendor/bin/phpunit --testdox --bootstrap ./vendor/autoload.php tests
PHPUnit 9.1.3 by Sebastian Bergmann and contributors.

Get Contents From Function
 ✔ Regular input

Time: 00:00.030, Memory: 4.00 MB

OK (1 test, 1 assertion)

```