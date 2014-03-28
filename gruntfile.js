module.exports = function(grunt) {

    var csspath = 'includes/css/',
        jspath  = 'includes/js/';
   
    // required files
    require('time-grunt')(grunt);

    // initialize
    grunt.initConfig({

        pkg : grunt.file.readJSON('package.json'),

        jsbanner: [
            '// v - <%= grunt.template.today("yyyy-mm-dd HH:MM") %>',
            ''
        ].join('\n'),

        cssbanner: [
            '/* v - <%= grunt.template.today("yyyy-mm-dd HH:MM") %> */',
        ].join('\n'),

        cssmin: {
          css: {
            options: {
              banner: '<%= cssbanner %>'
            },
            files : [{
                    expand: true, 
                    cwd: csspath,
                    src: ['**/*.full.css'],
                    dest: csspath,
                    ext: '.min.css'
                  }
                ]
          }
        },
        
        imagemin: {
           img: {
              files: [{
                expand: true, 
                cwd: 'includes/img/src/',
                src: ['**/*.{png,jpg,gif}'],
                dest: 'includes/img/opt/'
              }]
            }
        },

        jshint: {
            files: ['gruntfile.js', jspath + '*.full.js'],
            options:{
                eqeqeq      : true,
                evil        : true
            }
        },

        uglify: {
            options: {
                banner: '<%= jsbanner %>',
                mangle          : true,
                'screw-ie8'     : true,
                compress    : {
                    unused          : false,
                    dead_code       : false,
                    warnings        : true,
                    drop_console    : true
                }                    
            },
            js : {
                files : [{
                    expand: true, 
                    cwd: jspath,
                    src: ['**/*.full.js'],
                    dest: jspath,
                    ext: '.min.js'
                  }
                ]
            }           
        },

        watch: {
            jshint: {
                files: [jspath + '*.full.js'],
                tasks: ['newer:jshint','newer:uglify'],
                options: {
                    spawn: false,
                },
            },

            cssmin: {
                files: [csspath + '*.full.css'],
                tasks: ['newer:cssmin'],
                options: {
                    spawn: false,
                },
            } 
        }
    });

    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-cssmin');
    grunt.loadNpmTasks('grunt-contrib-imagemin');
    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-newer');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-watch');

    grunt.registerTask('build',   ['newer:jshint', 'newer:uglify', 'newer:cssmin']);
    grunt.registerTask('default', ['build']);

};