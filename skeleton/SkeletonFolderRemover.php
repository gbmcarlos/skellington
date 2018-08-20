<?php
/**
 * Created by PhpStorm.
 * User: gbmcarlos
 * Date: 2/18/18
 * Time: 4:12 PM
 */

namespace skeleton;

use Composer\Script\Event;

class SkeletonFolderRemover {

    CONST SKELETON_FOLDER = '/skeleton';

    public static function run(Event $event) {

        $skeletonDir = getcwd() . self::SKELETON_FOLDER;

        self::removeFolderRecursively($skeletonDir);

    }

    private static function removeFolderRecursively(string $dir) {

        $iterator = new \RecursiveIteratorIterator(
            new \RecursiveDirectoryIterator(
                $dir,
                \RecursiveDirectoryIterator::SKIP_DOTS
            ),
            \RecursiveIteratorIterator::CHILD_FIRST
        );

        /* @var $fileInfo \SplFileInfo */
        foreach($iterator as $fileInfo) {
            if ($fileInfo->isDir()) {
                rmdir($fileInfo->getPathname());
            } else {
                unlink($fileInfo->getPathname());
            }
        }

        rmdir($dir);

    }

}