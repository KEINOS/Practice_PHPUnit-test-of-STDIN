<?php
// Sample usage or "getContentsFromStdin()" function. Call this script as below
//   $ echo 'World!' | php ./Main.php
// Expect result
//   Hello! World!
declare(strict_types=1);
namespace KEINOS\Sample;
require_once('../vendor/autoload.php');

echo 'Hello! ' . getContentsFromStdin();
