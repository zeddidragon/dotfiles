#include "dz60.h"
#include "action_layer.h"

#define _______ KC_TRNS //readability
#define NA KC_NO

#define L_BASE 0 // default
#define L_FN 1 // fn
#define L_META 2 // quantum stuff

#define SC_LS F(F_SC_LS)
#define SC_RS F(F_SC_RS)
#define SC_LG F(F_SC_LG)
#define SC_RG F(F_SC_RG)
#define SC_LA F(F_SC_LA)
#define SC_RA F(F_SC_RA)
#define QUOTES F(F_QUOTES)
#define BITS F(F_BITS)

#define CADET_COUNT 6

enum functions {
  F_SC_LS,
  F_SC_RS,
  F_SC_LG,
  F_SC_RG,
  F_SC_LA,
  F_SC_RA,
  F_QUOTES,
  F_BITS
};

const uint16_t cadet_table[CADET_COUNT][3] = {
  // Hold mod, tap mod, tap key
  // Modify this array to adjust for your locale and preferences
  // Must be same order as functions
  {KC_LSFT, KC_LSFT, KC_8}, // Left shift / (
  {KC_RSFT, KC_LSFT, KC_9}, // Right shift / )
  {KC_LGUI, KC_RALT, KC_8},  // Left GUI /
  {KC_RGUI, KC_RALT, KC_9},  // Right GUI / }
  {KC_LALT, KC_RALT, KC_7},  // Left alt / [
  {KC_RALT, KC_RALT, KC_0}   // Right alt / ]
};
const uint16_t triplet_table[][2] = {
  {KC_RSFT, KC_EQL},
  {KC_RALT, KC_RBRC}
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [L_BASE] = KEYMAP( //default Layer
    KC_GRAVE,KC_1,    KC_2,    KC_3,    KC_4,    KC_5,    KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_MINS, KC_EQL,  KC_PGDOWN,KC_PGUP,\
    KC_TAB,           KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,    KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    KC_LBRC, KC_RBRC, KC_NUHS, \
    KC_ESC,           KC_A,    KC_S,    KC_D,    KC_F,    KC_G,    KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN, KC_QUOT,          KC_ENT,  \
    SC_LS,   KC_NUBS, KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, SC_RS,   MO(L_META),       \
    KC_LCTL, SC_LG,   SC_LA,                     KC_SPC,  MO(L_FN),KC_BSPC,                   SC_RA,   SC_RG,   NA,      QUOTES,  BITS
  ),

  [L_FN] = KEYMAP( // FN as seen on laptops
    _______, KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,  KC_F12,  KC_HOME, KC_END,  \
    _______,          _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, \
    _______,          _______, _______, _______, _______, _______, KC_LEFT, KC_DOWN, KC_UP,   KC_RIGHT,_______, _______, _______, _______, \
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,          \
    _______, _______, _______,                   _______, _______, _______,                   _______, _______,          _______, _______
  ),

  [L_META] = KEYMAP( // Operations related to keyboard itself
    RESET,   _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, \
    _______,          _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, \
    BL_BRTG,          _______, _______, _______, _______, _______, BL_OFF,  BL_DEC,  BL_INC,  BL_ON,   _______, _______, _______, _______, \
    _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______, _______,          \
    _______, _______,          _______,          _______, _______, _______,                   _______, _______,          _______, _______
  ),
};

bool is_hold(keyrecord_t *record) {
  return (record->tap.count <= 0 || record->tap.interrupted);
};

void cadet_function(keyrecord_t *record, uint16_t hold_mod, uint16_t tap_mod, uint16_t tap_key) {
  // Generalised space cadet.
  // Gives a function that holds hold_mod on hold, or tap_mod+tap_key on tap.
  if (record->event.pressed) {
    if (is_hold(record)) {
      register_code(hold_mod);
    }
  }
  else {
    if (is_hold(record)) {
      unregister_code(hold_mod);
    }
    else {
      register_code(tap_mod);
      register_code(tap_key);
      unregister_code(tap_key);
      unregister_code(tap_mod);
    }
  }
};

void layer_cadet(keyrecord_t *record, uint16_t hold_layer, uint16_t return_layer, uint16_t tap_mod, uint16_t tap_key) {
  // Generalised space cadet but with a layer isntead of a mod on hold
  // Gives a function that holds hold_layer on hold, or tap_mod+tap_key on tap.
  if (record->event.pressed) {
    if (is_hold(record)) {
      layer_state_set(hold_layer);
    }
  }
  else {
    if (is_hold(record)) {
      //layer_state_set(return_layer);
      layer_clear();
    }
    else {
      register_code(tap_mod);
      register_code(tap_key);
      unregister_code(tap_key);
      unregister_code(tap_mod);
    }
  }
};

void triplet_function(keyrecord_t *record, uint16_t mod, uint16_t key) {
  if(record->event.pressed) {
    register_code(mod);
    register_code(key);
    unregister_code(key);
    register_code(key);
  } else {
    unregister_code(mod);
    unregister_code(key);
  }
};

// Custom Actions
const uint16_t PROGMEM fn_actions[] = {
  [F_SC_LS] = ACTION_FUNCTION_TAP(F_SC_LS),
  [F_SC_RS] = ACTION_FUNCTION_TAP(F_SC_RS),
  [F_SC_LG] = ACTION_FUNCTION_TAP(F_SC_LG),
  [F_SC_RG] = ACTION_FUNCTION_TAP(F_SC_RG),
  [F_SC_LA] = ACTION_FUNCTION_TAP(F_SC_LA),
  [F_SC_RA] = ACTION_FUNCTION_TAP(F_SC_RA),
  [F_QUOTES] =  ACTION_FUNCTION_TAP(F_QUOTES),
  [F_BITS] =    ACTION_FUNCTION_TAP(F_BITS),
};

void action_function(keyrecord_t *record, uint8_t id, uint8_t opt) {
  switch (id) {
    // I tried this DRY form earlier, with the same results.
    case F_SC_LS ... F_SC_RA:
      cadet_function(record, cadet_table[id][0], cadet_table[id][1], cadet_table[id][2]);
      break;
    case F_QUOTES ... F_BITS:
      id -= CADET_COUNT;
      triplet_function(record, triplet_table[id][0], triplet_table[id][1]);
      break;
  }
};

// Macros
const macro_t *action_get_macro(keyrecord_t *record, uint8_t id, uint8_t opt) {

  // MACRODOWN only works in this function
  switch(id) {
    case 0:
      if (record->event.pressed) { register_code(KC_RSFT); }
      else { unregister_code(KC_RSFT); }
      break;
  }

  return MACRO_NONE;
};

// Loop
void matrix_scan_user(void) {
  // Empty
};
