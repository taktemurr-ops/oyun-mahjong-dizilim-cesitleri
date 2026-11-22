import 'package:eslestirme_motoru/eslestirme_motoru.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oyun_mahjong_dizilim_cesitleri/oyun_mahjong_dizilim_cesitleri.dart';
import 'package:studio_core/core/level_plan.dart';

void main() {
  test('10 çeşit, kimlikler benzersiz, 33 dil', () {
    expect(mahjongDzConfigs.length, 10);
    expect(mahjongDzConfigs.map((c) => c.gameId).toSet().length, 10);
    expect(mahjongDzGroup.title.length, 33);
    for (final c in mahjongDzConfigs) {
      expect(c.title.length, 33);
      expect(c.tagline.length, 33);
    }
  });

  for (final rules in mahjongDzRules) {
    test('${rules.gameId}: bölümler üretilir ve doğrulanır', () {
      final planner = LevelPlanner(gameId: rules.gameId, optionalMechanics: const []);
      for (final lv in [1, 54321]) {
        final gl = rules.build(planner.spec(lv));
        expect(gl.validation.ok, isTrue, reason: '${rules.gameId} $lv');
        expect(MLevel.fromJson(gl.puzzle.toJson()).kind, gl.puzzle.kind);
      }
    });
  }
}
