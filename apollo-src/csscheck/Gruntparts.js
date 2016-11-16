
var mf = module.filename.substring(0, module.filename.length - 'Gruntparts.js'.length);
exports.mf = mf;

exports.templates = [ 
	'apollo-additions', 
	'apollo-animation',
    'apollo-basics',
    'apollo-blog', 
    'apollo-button',
    'apollo-contact',
    'apollo-effects', 
    'apollo-event',
    'apollo-footer',
    'apollo-generics', 
    'apollo-job',
    'apollo-layoutrow',
    'apollo-linksequence',
    'apollo-list',
    'apollo-navigation',
    'apollo-section',
    'apollo-sitemap', 
    'apollo-slider',
    'apollo-socialicons',
    'apollo-tabs',
    'apollo-tiles',
    'container-markers',
];

exports.deployTarget = process.env.OCMOUNT + '/system/modules/org.opencms.apollo.theme/resources';

exports.sassSrc = [
	mf + '*.scss', 
];

exports.resources = [
    mf + 'ap-includes.jsp',
];
