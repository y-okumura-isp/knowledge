var gulp = require('gulp');
var usemin = require('gulp-usemin');
var uglify = require('gulp-uglify');
var minifyHtml = require('gulp-minify-html');
var minifyCss = require('gulp-minify-css');
var rev = require('gulp-rev');
//var replace = require('gulp-replace');

gulp.task('min', function() {
    return gulp.src([
        'src/main/webapp/WEB-INF/views/**/*.jsp'
    ])
    .pipe(usemin({
        css: [rev],
        htmlmin: [ function () {return minifyHtml({ empty: true });} ],
        js: [uglify, rev],
        inlinejs: [ uglify ],
        inlinecss: [ minifyCss, 'concat' ],
        outputRelativePath: '../../'
    }))
//    .pipe(replace('bar', 'foo'))
    .pipe(gulp.dest('target/knowledge/WEB-INF/views/'));
});

gulp.task('copy', ['copy:raw']);
gulp.task('copy:raw', function() {
    return gulp.src([
            'bower/bootswatch/*',
            'bower/highlightjs/*',
            'bower/font-awesome/fonts/*',
            'bower/flag-icon-css/*',
            'bower/MathJax/*'
        ]
    )
    .pipe(gulp.dest('target/knowledge/bower'));
});




gulp.task('default', ['min', 'copy']);
