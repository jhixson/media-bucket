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
        },
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
};
