extends "res://addons/gut/test.gd"

func before_each():
	gut.file_touch('user://some_test_file')

func after_each():
	gut.file_delete('user://some_test_file')


func test_pending():
	pending('This test is not implemented yet')
	pending()

func test_equals():
	var one = 1
	var node1 = Node.new()
	var node2 = node1

	assert_eq(one, 1, 'one should equal one') # PASS
	assert_eq('racecar', 'racecar') # PASS
	assert_eq(node2, node1) # PASS

	gut.p('-- failing --')
	assert_eq(1, 2) # FAIL
	assert_eq('hello', 'world') # FAIL
	assert_eq(self, node1) # FAIL

func test_not_equal():
	var two = 2
	var node1 = Node.new()

	gut.p('-- passing --')
	assert_ne(two, 1, 'Two should not equal one.')  # PASS
	assert_ne('hello', 'world') # PASS
	assert_ne(self, node1) # PASS

	gut.p('-- failing --')
	assert_ne(two, 2) # FAIL
	assert_ne('one', 'one') # FAIL
	assert_ne('2', 2) # FAIL

func test_almost_equals():

	gut.p('-- passing --')
	assert_almost_eq(0, 1, 1, '0 within range of 1 +/- 1') # PASS
	assert_almost_eq(2, 1, 1, '2 within range of 1 +/- 1') # PASS

	assert_almost_eq(1.2, 1.0, .5, '1.2 within range of 1 +/- .5') # PASS
	assert_almost_eq(.5, 1.0, .5, '.5 within range of 1 +/- .5') # PASS

	assert_almost_eq(Vector2(.5, 1.5), Vector2(1.0, 1.0), Vector2(.5, .5))  # PASS

	gut.p('-- failing --')
	assert_almost_eq(1, 3, 1, '1 outside range of 3 +/- 1') # FAIL
	assert_almost_eq(2.6, 3.0, .2, '2.6 outside range of 3 +/- .2') # FAIL

	assert_almost_eq(Vector2(.5, 1.5), Vector2(1.0, 1.0), Vector2(.25, .25))  # PASS

func test_almost_not_equals():
	gut.p('-- passing --')
	assert_almost_ne(1, 3, 1, '1 outside range of 3 +/- 1') # PASS
	assert_almost_ne(2.6, 3.0, .2, '2.6 outside range of 3 +/- .2') # PASS

	assert_almost_ne(Vector2(.5, 1.5), Vector2(1.0, 1.0), Vector2(.25, .25))  # PASS

	gut.p('-- failing --')
	assert_almost_ne(0, 1, 1, '0 within range of 1 +/- 1') # FAIL
	assert_almost_ne(2, 1, 1, '2 within range of 1 +/- 1') # FAIL

	assert_almost_ne(1.2, 1.0, .5, '1.2 within range of 1 +/- .5') # FAIL
	assert_almost_ne(.5, 1.0, .5, '.5 within range of 1 +/- .5') # FAIL

	assert_almost_ne(Vector2(.5, 1.5), Vector2(1.0, 1.0), Vector2(.5, .5))  # FAIL

func test_greater_than():
	var bigger = 5
	var smaller = 0

	gut.p('-- passing --')
	assert_gt(bigger, smaller, 'Bigger should be greater than smaller') # PASS
	assert_gt('b', 'a') # PASS
	assert_gt('a', 'A') # PASS
	assert_gt(1.1, 1) # PASS

	gut.p('-- failing --')
	assert_gt('a', 'a') # FAIL
	assert_gt(1.0, 1) # FAIL
	assert_gt(smaller, bigger) # FAIL

func test_less_than():
	var bigger = 5
	var smaller = 0
	gut.p('-- passing --')
	assert_lt(smaller, bigger, 'Smaller should be less than bigger') # PASS
	assert_lt('a', 'b') # PASS

	gut.p('-- failing --')
	assert_lt('z', 'x') # FAIL
	assert_lt(-5, -5) # FAIL

func test_true():
	gut.p('-- passing --')
	assert_true(true, 'True should be true') # PASS
	assert_true(5 == 5, 'That expressions should be true') # PASS

	gut.p('-- failing --')
	assert_true(false) # FAIL
	assert_true('a' == 'b') # FAIL

func test_false():
	gut.p('-- passing --')
	assert_false(false, 'False is false') # PASS
	assert_false(1 == 2) # PASS
	assert_false('a' == 'z') # PASS
	assert_false(self.has_user_signal('nope')) # PASS

	gut.p('-- failing --')
	assert_false(true) # FAIL
	assert_false('ABC' == 'ABC') # FAIL


func test_assert_between():
	gut.p('-- passing --')
	assert_between(5, 0, 10, 'Five should be between 0 and 10') # PASS
	assert_between(10, 0, 10) # PASS
	assert_between(0, 0, 10) # PASS
	assert_between(2.25, 2, 4.0) # PASS

	gut.p('-- failing --')
	assert_between('a', 'b', 'c') # FAIL
	assert_between(1, 5, 10) # FAIL


func test_has():
	var an_array = [1, 2, 3, 'four', 'five']
	var a_hash = { 'one':1, 'two':2, '3':'three'}

	gut.p('-- passing --')
	assert_has(an_array, 'four') # PASS
	assert_has(an_array, 2) # PASS
	# the hash's has method checkes indexes not values
	assert_has(a_hash, 'one') # PASS
	assert_has(a_hash, '3') # PASS

	gut.p('-- failing --')
	assert_has(an_array, 5) # FAIL
	assert_has(an_array, self) # FAIL
	assert_has(a_hash, 3) # FAIL
	assert_has(a_hash, 'three') # FAIL

func test_does_not_have():
	var an_array = [1, 2, 3, 'four', 'five']
	var a_hash = { 'one':1, 'two':2, '3':'three'}

	gut.p('-- passing --')
	assert_does_not_have(an_array, 5) # PASS
	assert_does_not_have(an_array, self) # PASS
	assert_does_not_have(a_hash, 3) # PASS
	assert_does_not_have(a_hash, 'three')

	gut.p('-- failing --')
	assert_does_not_have(an_array, 'four') # FAIL
	assert_does_not_have(an_array, 2) # FAIL
	# the hash's has method checkes indexes not values
	assert_does_not_have(a_hash, 'one') # FAIL
	assert_does_not_have(a_hash, '3') # FAIL

func test_string_contains():
	gut.p('-- passing --')
	assert_string_contains('abc 123', 'a')
	assert_string_contains('abc 123', 'BC', false)
	assert_string_contains('abc 123', '3')

	gut.p('-- failing --')
	assert_string_contains('abc 123', 'A')
	assert_string_contains('abc 123', 'BC')
	assert_string_contains('abc 123', '012')

func test_string_starts_with():
	gut.p('-- passing --')
	assert_string_starts_with('abc 123', 'a')
	assert_string_starts_with('abc 123', 'ABC', false)
	assert_string_starts_with('abc 123', 'abc 123')

	gut.p('-- failing --')
	assert_string_starts_with('abc 123', 'z')
	assert_string_starts_with('abc 123', 'ABC')
	assert_string_starts_with('abc 123', 'abc 1234')

func test_string_ends_with():
	gut.p('-- passing --')
	assert_string_ends_with('abc 123', '123')
	assert_string_ends_with('abc 123', 'C 123', false)
	assert_string_ends_with('abc 123', 'abc 123')

	gut.p('-- failing --')
	assert_string_ends_with('abc 123', '1234')
	assert_string_ends_with('abc 123', 'C 123')
	assert_string_ends_with('abc 123', 'nope')

func test_assert_file_exists():
	gut.p('-- passing --')
	assert_file_exists('res://addons/gut/gut.gd') # PASS
	assert_file_exists('user://some_test_file') # PASS

	gut.p('-- failing --')
	assert_file_exists('user://file_does_not.exist') # FAIL
	assert_file_exists('res://some_dir/another_dir/file_does_not.exist') # FAIL

func test_assert_file_does_not_exist():
	gut.p('-- passing --')
	assert_file_does_not_exist('user://file_does_not.exist') # PASS
	assert_file_does_not_exist('res://some_dir/another_dir/file_does_not.exist') # PASS

	gut.p('-- failing --')
	assert_file_does_not_exist('res://addons/gut/gut.gd') # FAIL

func test_assert_file_empty():
	gut.p('-- passing --')
	assert_file_empty('user://some_test_file') # PASS

	gut.p('-- failing --')
	assert_file_empty('res://addons/gut/gut.gd')

func test_assert_file_not_empty():
	gut.p('-- passing --')
	assert_file_not_empty('res://addons/gut/gut.gd') # PASS

	gut.p('-- failing --')
	assert_file_not_empty('user://some_test_file') # FAIL

# ------------------------------------------------------------------------------
class SomeClass:
	var _count = 0

	func get_count():
		return _count
	func set_count(number):
		_count = number

	func get_nothing():
		pass
	func set_nothing(val):
		pass

func test_assert_accessors():
	var some_class = SomeClass.new()
	gut.p('-- passing --')
	assert_accessors(some_class, 'count', 0, 20) # 4 PASSING

	gut.p('-- failing --')
	# 1 FAILING, 3 PASSING
	assert_accessors(some_class, 'count', 'not_default', 20)
	# 2 FAILING, 2 PASSING
	assert_accessors(some_class, 'nothing', 'hello', 22)
	# 2 FAILING
	assert_accessors(some_class, 'does_not_exist', 'does_not', 'matter')

func test_assert_has_method():
	var some_class = SomeClass.new()
	gut.p('-- passing --')
	assert_has_method(some_class, 'get_nothing')
	assert_has_method(some_class, 'set_count')

	gut.p('-- failing --')
	assert_has_method(some_class, 'method_does_not_exist')

# ------------------------------------------------------------------------------
class ExportClass:
	export var some_number = 5
	export(PackedScene) var some_scene
	var some_variable = 1

func test_assert_exports():
	var obj = ExportClass.new()

	gut.p('-- passing --')
	assert_exports(obj, "some_number", TYPE_INT)
	assert_exports(obj, "some_scene", TYPE_OBJECT)

	gut.p('-- failing --')
	assert_exports(obj, 'some_number', TYPE_VECTOR2)
	assert_exports(obj, 'some_scene', TYPE_AABB)
	assert_exports(obj, 'some_variable', TYPE_INT)
# ------------------------------------------------------------------------------

class MovingNode:
	extends Node2D
	var _speed = 2

	func _ready():
		set_process(true)

	func _process(delta):
		set_position(get_position() + Vector2(_speed * delta, 0))

func test_illustrate_yield():
	var moving_node = MovingNode.new()
	add_child(moving_node)
	moving_node.set_position(Vector2(0, 0))

	# While the yield happens, the node should move
	yield(yield_for(2), YIELD)
	assert_gt(moving_node.get_position().x, 0)
	assert_between(moving_node.get_position().x, 3.9, 4, 'it should move almost 4 whatevers at speed 2')

func test_illustrate_end_test():
	yield(yield_for(1), YIELD)
	# we don't have anything to test yet, or at all.  So we
	# call end_test so that Gut knows all the yielding has
	# finished.
	end_test()

# ------------------------------------------------------------------------------
class TimedSignaler:
	extends Node2D
	var _time = 0

	signal the_signal
	func _init(time):
		_time = time

	func start():
		var t = Timer.new()
		add_child(t)
		t.set_wait_time(_time)
		t.connect('timeout', self, '_on_timer_timeout')
		t.set_one_shot(true)
		t.start()

	func _on_timer_timeout():
		emit_signal('the_signal')

func test_illustrate_yield_to_with_less_time():
	var t = TimedSignaler.new(5)
	add_child(t)
	t.start()
	yield(yield_to(t, 'the_signal', 1), YIELD)
	# since we setup t to emit after 5 seconds, this will fail because we
	# only yielded for 1 second vail yield_to
	assert_signal_emitted(t, 'the_signal', 'This will fail')

func test_illustrate_yield_to_with_more_time():
	var t = TimedSignaler.new(1)
	add_child(t)
	t.start()
	yield(yield_to(t, 'the_signal', 5), YIELD)
	# since we wait longer than it will take to emit the signal, this assert
	# will pass
	assert_signal_emitted(t, 'the_signal', 'This will pass')

# ------------------------------------------------------------------------------
class SignalObject:
	func _init():
		add_user_signal('some_signal')
		add_user_signal('other_signal')

func test_assert_signal_emitted():
	var obj = SignalObject.new()

	watch_signals(obj)
	obj.emit_signal('some_signal')

	gut.p('-- passing --')
	assert_signal_emitted(obj, 'some_signal')

	gut.p('-- failing --')
	# Fails with specific message that the object does not have the signal
	assert_signal_emitted(obj, 'signal_does_not_exist')
	# Fails because the object passed is not being watched
	assert_signal_emitted(SignalObject.new(), 'some_signal')
	# Fails because the signal was not emitted
	assert_signal_emitted(obj, 'other_signal')

func test_assert_signal_not_emitted():
	var obj = SignalObject.new()

	watch_signals(obj)
	obj.emit_signal('some_signal')

	gut.p('-- passing --')
	assert_signal_not_emitted(obj, 'other_signal')

	gut.p('-- failing --')
	# Fails with specific message that the object does not have the signal
	assert_signal_not_emitted(obj, 'signal_does_not_exist')
	# Fails because the object passed is not being watched
	assert_signal_not_emitted(SignalObject.new(), 'some_signal')
	# Fails because the signal was emitted
	assert_signal_not_emitted(obj, 'some_signal')

func test_assert_signal_emitted_with_parameters():
	var obj = SignalObject.new()

	watch_signals(obj)
	# emit the signal 3 times to illustrate how the index works in
	# assert_signal_emitted_with_parameters
	obj.emit_signal('some_signal', 1, 2, 3)
	obj.emit_signal('some_signal', 'a', 'b', 'c')
	obj.emit_signal('some_signal', 'one', 'two', 'three')

	gut.p('-- passing --')
	# Passes b/c the default parameters to check are the last emission of
	# the signal
	assert_signal_emitted_with_parameters(obj, 'some_signal', ['one', 'two', 'three'])
	# Passes because the parameters match the specified emission based on index.
	assert_signal_emitted_with_parameters(obj, 'some_signal', [1, 2, 3], 0)

	gut.p('-- failing --')
	# Fails with specific message that the object does not have the signal
	assert_signal_emitted_with_parameters(obj, 'signal_does_not_exist', [])
	# Fails because the object passed is not being watched
	assert_signal_emitted_with_parameters(SignalObject.new(), 'some_signal', [])
	# Fails because parameters do not match latest emission
	assert_signal_emitted_with_parameters(obj, 'some_signal', [1, 2, 3])
	# Fails because the parameters for the specified index do not match
	assert_signal_emitted_with_parameters(obj, 'some_signal', [1, 2, 3], 1)

func test_assert_signal_emit_count():
	var obj_a = SignalObject.new()
	var obj_b = SignalObject.new()

	watch_signals(obj_a)
	watch_signals(obj_b)
	obj_a.emit_signal('some_signal')
	obj_a.emit_signal('some_signal')

	obj_b.emit_signal('some_signal')
	obj_b.emit_signal('other_signal')

	gut.p('-- passing --')
	assert_signal_emit_count(obj_a, 'some_signal', 2)
	assert_signal_emit_count(obj_a, 'other_signal', 0)

	assert_signal_emit_count(obj_b, 'other_signal', 1)

	gut.p('-- failing --')
	# Fails with specific message that the object does not have the signal
	assert_signal_emit_count(obj_a, 'signal_does_not_exist', 99)
	# Fails because the object passed is not being watched
	assert_signal_emit_count(SignalObject.new(), 'some_signal', 99)
	# The following fail for obvious reasons
	assert_signal_emit_count(obj_a, 'some_signal', 0)
	assert_signal_emit_count(obj_b, 'other_signal', 283)

func test_assert_has_signal():
	var obj = SignalObject.new()

	gut.p('-- passing --')
	assert_has_signal(obj, 'some_signal')
	assert_has_signal(obj, 'other_signal')

	gut.p('-- failing --')
	assert_has_signal(obj, 'not_a real SIGNAL')
	assert_has_signal(obj, 'yea, this one doesnt exist either')
	# Fails because the signal is not a user signal.  Node2D does have the
	# specified signal but it can't be checked this way.  It could be watched
	# and asserted that it fired though.
	assert_has_signal(Node2D.new(), 'exit_tree')

func test_get_signal_parameters():
	var obj = SignalObject.new()
	watch_signals(obj)
	obj.emit_signal('some_signal', 1, 2, 3)
	obj.emit_signal('some_signal', 'a', 'b', 'c')

	gut.p('-- passing --')
	# passes because get_signal_parameters returns the most recent emission
	# by default
	assert_eq(get_signal_parameters(obj, 'some_signal'), ['a', 'b', 'c'])
	assert_eq(get_signal_parameters(obj, 'some_signal', 0), [1, 2, 3])
	# if the signal was not fired null is returned
	assert_eq(get_signal_parameters(obj, 'other_signal'), null)
	# if the signal does not exist or isn't being watched null is returned
	assert_eq(get_signal_parameters(obj, 'signal_dne'), null)

	gut.p('-- failing --')
	assert_eq(get_signal_parameters(obj, 'some_signal'), [1, 2, 3])
	assert_eq(get_signal_parameters(obj, 'some_signal', 0), ['a', 'b', 'c'])

# ------------------------------------------------------------------------------
class BaseClass:
	var a = 1
class SubClass:
	extends BaseClass


func test_assert_is():
	gut.p('-- passing --')
	assert_is(Node2D.new(), Node2D)
	assert_is(Label.new(), CanvasItem)
	assert_is(SubClass.new(), BaseClass)
	# Since this is a test script that inherits from test.gd, so
	# this passes.  It's not obvious w/o seeing the whole script
	# so I'm telling you.  You'll just have to trust me.
	assert_is(self, load('res://addons/gut/test.gd'))

	var Gut = load('res://addons/gut/gut.gd')
	var a_gut = Gut.new()
	assert_is(a_gut, Gut)

	gut.p('-- failing --')
	assert_is(Node2D.new(), Node2D.new())
	assert_is(BaseClass.new(), SubClass)
	assert_is('a', 'b')
	assert_is([], Node)

# ------------------------------------------------------------------------------
func test_assert_called():
	var DOUBLE_ME_PATH = 'res://test/doubler_test_objects/double_extends_node2d.gd'

	var doubled = double(DOUBLE_ME_PATH).new()
	doubled.set_value(4)
	doubled.set_value(5)
	doubled.has_two_params_one_default('a')
	doubled.has_two_params_one_default('a', 'b')
	doubled.get_position()
	doubled.set_position(Vector2(100, 100))

	gut.p('-- passing --')
	assert_called(doubled, 'set_value')
	assert_called(doubled, 'set_value', [5])
	assert_called(doubled, 'has_two_params_one_default', ['a', null])
	assert_called(doubled, 'has_two_params_one_default', ['a', 'b'])
	assert_called(doubled, 'get_position')

	gut.p('-- failing --')
	assert_called(doubled, 'get_value')
	assert_called(doubled, 'set_value', ['nope'])
	# This fails b/c double_me.gd does not implement a version of this method and
	# is not yet being tracked by gut.  This should change in future.
	assert_called(doubled, 'set_position')
	# This fails b/c Gut isn't smart enough to fill in default values for you...
	# ast least not yet.
	assert_called(doubled, 'has_two_params_one_default', ['a'])
	# This fails with a specific message indicating that you have to pass an
	# instance of a doubled class.
	assert_called(GDScript.new(), 'some_method')

func test_assert_call_count():
	var DOUBLE_ME_PATH = 'res://test/doubler_test_objects/double_extends_node2d.gd'

	var doubled = double(DOUBLE_ME_PATH).new()
	doubled.set_value(4)
	doubled.set_value(5)
	doubled.has_two_params_one_default('a')
	doubled.has_two_params_one_default('a', 'b')
	doubled.set_position(Vector2(100, 100))

	gut.p('-- passing --')
	assert_call_count(doubled, 'set_value', 2)
	assert_call_count(doubled, 'set_value', 1, [4])
	assert_call_count(doubled, 'has_two_params_one_default', 1, ['a', null])
	assert_call_count(doubled, 'get_value', 0)

	gut.p('-- failing --')
	assert_call_count(doubled, 'set_value', 5)
	assert_call_count(doubled, 'set_value', 2, [4])
	assert_call_count(doubled, 'get_value', 1)
	# This fails with a specific message indicating that you have to pass an
	# instance of a doubled class even though technically the method was called.
	assert_call_count(GDScript.new(), 'some_method', 0)
	# This fails b/c double_extends_node2d does not have it's own implementation
	# of set_position.  The function is supplied by the parent class and these
	# methods are not yet being recorded.
	assert_call_count(doubled, 'set_position', 1)
