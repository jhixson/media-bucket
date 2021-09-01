module.exports = {
  mode: 'jit',
  purge: ['./js/**/*.js', '../lib/*_web/**/*.*ex'],
  theme: {
    extend: {
      colors: {
        gray: {
          800: '#1e1f1f',
          700: '#272828',
          600: '#3e3e3f',
          200: '#e4e3e3',
        },
      },
      fontFamily: {
        body: '"Roboto", Helvetica, Arial, sans-serif;',
        display: '"Secular One", Helvetica, Arial, sans-serif',
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
};
