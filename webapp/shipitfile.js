module.exports = function (shipit) {
  require('shipit-deploy')(shipit);
  require('shipit-npm')(shipit);
  require('shipit-bower')(shipit);

  shipit.initConfig({
    default: {
      workspace: '../tmp',
      repositoryUrl: 'git@github.com:bingneef/duckhunt.git',
      deployTo: '/var/www/duckhunt/',
      dirToCopy: 'webapp/dist',
      ignores: ['.git', 'node_modules', 'bower_components'],
      keepReleases: 10,
      deleteOnRollback: false,
      shallowClone: false,
      npm: {
        remote: false
      },
      bower: {
        remote: false
      }
    },
    production: {
      servers: 'bing@5.157.85.46',
      branch: 'master',
      environment: 'master'
    }
  });

  shipit.blTask('gulp:build', function() {
    return shipit.local('gulp --environment=' + shipit.config.environment + ' --gulpfile ' + shipit.config.workspace + '/webapp/gulpfile.js')
  });

  shipit.on('fetched', function() {
    shipit.config.workspace_original = shipit.config.workspace;
    shipit.config.workspace = shipit.config.workspace + '/webapp';
  });

  shipit.on('bower_installed', function() {
    shipit.config.workspace = shipit.config.workspace_original;
    return shipit.start('gulp:build');
  });
};
