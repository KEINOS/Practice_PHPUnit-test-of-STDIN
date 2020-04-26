<?php
declare(strict_types=1);

namespace KEINOS\Sample;

function getContentsFromStdin()
{
    $contents = \file_get_contents('php://stdin');
    if ($contents === false) {
        throw new \RuntimeException('Failed to read contents from STDIN.');
    }

    return $contents;
}
