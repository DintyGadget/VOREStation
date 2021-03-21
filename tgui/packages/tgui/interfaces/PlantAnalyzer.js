import { round } from 'common/math';
import { Fragment } from 'inferno';
import { useBackend } from "../backend";
import { Box, Button, Flex, Icon, LabeledList, ProgressBar, Section, NoticeBox } from "../components";
import { Window } from "../layouts";

export const PlantAnalyzer = (props, context) => {
  const { data } = useBackend(context);
  
  let calculatedHeight = 250;
  if (data.seed) {
    calculatedHeight += (18 * data.seed.trait_info.length);
  }
  if (data.reagents && data.reagents.length) {
    calculatedHeight += 55;
    calculatedHeight += (20 * data.reagents.length);
  }

  // Resizable just in case the calculatedHeight fails
  return (
    <Window width={400} height={calculatedHeight} resizable>
      <Window.Content scrollable>
        <PlantAnalyzerContent />
      </Window.Content>
    </Window>
  );
};

const PlantAnalyzerContent = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    no_seed,
    seed,
    reagents,
  } = data;

  if (no_seed) {
    return (
      <Section title="Analyzer Unused">
        Вам следует просканировать растение! В настоящее время нет загруженных данных.
      </Section>
    );
  }

  return (
    <Section title="Информация о растении" buttons={
      <Fragment>
        <Button
          icon="print"
          onClick={() => act("print")}>
          Печать
        </Button>
        <Button
          icon="window-close"
          color="red"
          onClick={() => act("close")} />
      </Fragment>
    }>
      <LabeledList>
        <LabeledList.Item label="Название">
          {seed.name}#{seed.uid}
        </LabeledList.Item>
        <LabeledList.Item label="Выносливость">
          {seed.endurance}
        </LabeledList.Item>
        <LabeledList.Item label="Урожай">
          {seed.yield}
        </LabeledList.Item>
        <LabeledList.Item label="Время созревания">
          {seed.maturation_time}
        </LabeledList.Item>
        <LabeledList.Item label="Сроки изготовления">
          {seed.production_time}
        </LabeledList.Item>
        <LabeledList.Item label="Потенция">
          {seed.potency}
        </LabeledList.Item>
      </LabeledList>
      {reagents.length && (
        <Section level={2} title="Plant Reagents">
          <LabeledList>
            {reagents.map(r => (
              <LabeledList.Item key={r.name} label={r.name}>
                {r.volume} unit(s).
              </LabeledList.Item>
            ))}
          </LabeledList>
        </Section>
      ) || null}
      <Section level={2} title="Другие данные">
        {seed.trait_info.map(trait => (
          <Box color="label" key={trait} mb={0.4}>{trait}</Box>
        ))}
      </Section>
    </Section>
  );
};