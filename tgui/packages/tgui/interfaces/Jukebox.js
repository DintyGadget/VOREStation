import { round } from 'common/math';
import { sortBy } from 'common/collections';
import { useBackend } from "../backend";
import { Box, Button, LabeledList, ProgressBar, Section, Slider } from "../components";
import { Window } from "../layouts";

export const Jukebox = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    playing,
    loop_mode,
    volume,
    current_track_ref,
    current_track,
    percent,
    tracks,
  } = data;

  return (
    <Window width={450} height={600} resizable>
      <Window.Content scrollable>
        <Section title="Сейчас играет">
          <LabeledList>
            <LabeledList.Item label="Название">
              {playing && current_track && (
                <Box>
                  {current_track.title} by {current_track.artist || "Неизвест."}
                </Box>
              ) || (
                <Box>
                  Остановлено
                </Box>
              )}
            </LabeledList.Item>
            <LabeledList.Item label="Управление">
              <Button
                icon="play"
                disabled={playing}
                onClick={() => act("play")}>
                Пуск
              </Button>
              <Button
                icon="stop"
                disabled={!playing}
                onClick={() => act("stop")}>
                Стоп
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="Режим">
              <Button
                icon="play"
                onClick={() => act("loopmode", { loopmode: 1 })}
                selected={loop_mode === 1}>
                След
              </Button>
              <Button
                icon="random"
                onClick={() => act("loopmode", { loopmode: 2 })}
                selected={loop_mode === 2}>
                Перемешать
              </Button>
              <Button
                icon="redo"
                onClick={() => act("loopmode", { loopmode: 3 })}
                selected={loop_mode === 3}>
                Повтор
              </Button>
              <Button
                icon="step-forward"
                onClick={() => act("loopmode", { loopmode: 4 })}
                selected={loop_mode === 4}>
                Once
              </Button>
            </LabeledList.Item>
            <LabeledList.Item label="Прогресс">
              <ProgressBar
                value={percent}
                maxValue={1}
                color="good" />
            </LabeledList.Item>
            <LabeledList.Item label="Громкость">
              <Slider
                minValue={0}
                step={0.01}
                value={volume}
                maxValue={1}
                ranges={{
                  good: [.75, Infinity],
                  average: [.25, .75],
                  bad: [0, .25],
                }}
                format={val => round(val * 100, 1) + "%"}
                onChange={(e, val) => act("volume", { val: round(val, 2) })} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Доступные треки">
          {tracks.length && sortBy(a => a.title)(tracks).map(track => (
            <Button
              fluid
              icon="play"
              key={track.ref}
              selected={current_track_ref === track.ref}
              onClick={() => act("change_track", { change_track: track.ref })}>
              {track.title}
            </Button>
          )) || (
            <Box color="bad">
              ОШИБКА: Музыка не загружена.
            </Box>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};