const path = require('path')

const resolve = dir => {
  return path.join(__dirname, dir)
}

// ��Ŀ�������
// Ĭ������£����Ǽ������Ӧ�ý�����������ĸ�Ŀ¼��,
// ���磺https://www.my-app.com/
// Ĭ�ϣ�'/'
// �������Ӧ�ó���������·���У�����Ҫ����ָ����·��
// ���磺https://www.foobar.com/my-app/
// ��Ҫ������Ϊ'/my-app/'
// iview-admin������ʾ���·���� https://file.iviewui.com/admin-dist/
const BASE_URL = process.env.NODE_ENV === 'production'
  ? '/'
  : '/'

module.exports = {
  // Project deployment base
  // By default we assume your app will be deployed at the root of a domain,
  // e.g. https://www.my-app.com/
  // If your app is deployed at a sub-path, you will need to specify that
  // sub-path here. For example, if your app is deployed at
  // https://www.foobar.com/my-app/
  // then change this to '/my-app/'
  baseUrl: BASE_URL,
  // tweak internal webpack configuration.
  // see https://github.com/vuejs/vue-cli/blob/dev/docs/webpack.md
  // ����㲻��Ҫʹ��eslint����lintOnSave��Ϊfalse����
  lintOnSave: true,
  chainWebpack: config => {
    config.resolve.alias
      .set('@', resolve('src')) // key,value���ж��壬����.set('@@', resolve('src/components'))
      .set('_c', resolve('src/components'))
  },
  // ��Ϊfalse���ʱ������.map�ļ�
  productionSourceMap: false
  // ����д����ýӿڵĻ���·���������������������˴������㱾�ؿ���������axios��baseUrlҪдΪ '' �������ַ���
  // devServer: {
  //   proxy: 'localhost:3000'
  // }
}