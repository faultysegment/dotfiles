#!/usr/bin/env python3
import json
import logging
import subprocess as ss

class Installer(object):
    def __init__(self):
        self.log = logging.getLogger("Installer")
        self.log.setLevel(logging.INFO)
        ch = logging.StreamHandler()
        ch.setLevel(logging.INFO)
        formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        ch.setFormatter(formatter)
        self.log.addHandler(ch)

    def _install_extension(self, uri: str) -> None:
        result = ss.run(['/usr/bin/env', 'code', '--install-extension', uri], stdin=ss.PIPE, stdout=ss.PIPE, check=False)
        if result.stdout is not None:
            self.log.info("stdout is not None, content:")
            self.log.info(result.stdout.decode("utf-8"))
        if result.stderr is not None:
            self.log.error("stderr is not None, content:")
            self.log.error(result.stderr.decode("utf-8"))

    def install(self) -> None:
        with open('extensions.json') as extensions_file:
            content = json.load(extensions_file)
            extensions = content['recommendations']
            for ext in extensions:
                self._install_extension(ext)


if __name__ == '__main__':
    Installer().install()
