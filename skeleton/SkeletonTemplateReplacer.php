<?php

namespace skeleton;

use Composer\Script\Event;

/**
 * Created by PhpStorm.
 * User: gbmcarlos
 * Date: 2/18/18
 * Time: 11:04 AM
 */
class SkeletonTemplateReplacer {

    CONST TEMPLATES_DIR = '/skeleton/templates';

    public static function run(Event $event) {

        $projectName = self::getProjectName($event);

        self::replaceTemplates(array(
            '{{projectName}}' => $projectName
        ));

    }

    private static function getProjectName(Event $event) : string {
        return basename(getcwd());
    }

    private static function replaceTemplates(array $variables) {

        $templatesDir = getcwd() . self::TEMPLATES_DIR;

        $iterator = new \RecursiveIteratorIterator(
            new \RecursiveDirectoryIterator(
                $templatesDir,
                \RecursiveDirectoryIterator::SKIP_DOTS
            )
        );

        /* @var $item \SplFileInfo */
        foreach ($iterator as $item) {
            self::renderAndReplace($item, $variables);
        }

    }

    private static function renderAndReplace(\SplFileInfo $file, $variables) {

        $fileObject = $file->openFile('r');
        $fileContent = $fileObject->fread($fileObject->getSize());
        $fileObject = null;

        $renderedContent = strtr($fileContent, $variables);

        $fileObject = $file->openFile('w');
        $fileObject->fwrite($renderedContent);

        $destination = self::getTemplateDestination($file);
        rename($file->getPathname(), $destination);

    }

    private static function getTemplateDestination(\SplFileInfo $file) {

        $nameReplaced = str_replace('-dist', '', $file->getPathname());
        $finalTarget =  str_replace(self::TEMPLATES_DIR, '', $nameReplaced);

        return $finalTarget;

    }

}