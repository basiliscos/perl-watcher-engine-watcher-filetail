perl-watcher-engine-watcher-filetail
====================================

Inotify-based file tail watcher allows you to track changes (e.g. log file addons)
on the particular file on filesystem.

Add to ~/.perl-watcher/engine.conf filetail watcher like:

```
        {
            class => 'App::PerlWatcher::Watcher::FileTail',
            config => {
                file    	=>  '/var/log/messages',
                lines_number    =>  10,
                filter  	=> sub { $_ !~ /\scron/ },
            },
        },

```


